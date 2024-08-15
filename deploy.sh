version: 2.1

jobs:
  build:
    docker:
      - image: circleci/golang:1.22  # Update to a valid tag
    steps:
      - checkout
      - run:
          name: Build Go Binary
          command: |
            go build -o myservice ./path/to/your/main.go
      - persist_to_workspace:
          root: .
          paths:
            - myservice

  deploy:
    docker:
      - image: circleci/python:3.8
    steps:
      - attach_workspace:
          at: /workspace
      - run:
          name: Deploy to AWS EC2
          command: |
            ./deploy.sh

workflows:
  version: 2
  deploy:
    jobs:
      - build
      - deploy:
          requires:
            - build
