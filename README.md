# PEAKFocus

Welcome to the **PEAKFocus** repository! This is the home of the **PEAKFocus** application, a project developed at [START Munich's 24h Hackathon 2023](https://www.linkedin.com/events/24hourhackathon-sportsandhealth7073922193423781888/about/) by team **PEAKFocus**:
- Fabian Mast, @fabianmast
- Oliver Klukas, @OliverKlukas
- Philipp Wulff, @philippwulff
- Shaurya Sharma, @shauryainf

# Challenge
Proposed by [brainboost](https://brainboost.de/en/) our great company partner for the hack, to drive innovation in the health- and sports-sector they gave this [challenge](https://www.linkedin.com/feed/update/urn:li:activity:7074671365953335296/):

> Create an innovative software prototype that seamlessly integrates with brainboost's diverse product portfolio of live neurofeedback and EEG data for atlethe training and state-of-the-art technology infrastructure.

# Product at a glance
**PEAKFocus** is a mobile app that allows athletes to train their **focus in the most important moments** of their game. Many athletes internalize a *routine* to achieve and maintain focus during competitions. Our solution improves the training of these routines by providing feedback from a brain interface. More specifically, athletes are challenged to reduce the volume of a control sound through staying in a *focused state of mind* (which we measure via their brain activity) while doing their routine. The result is a more achievable, robust and retainable routine.

Check out our [pitch](assets/PeakFocusPitch.pdf) for more details and watch the following product demo:

![PEAKFocus](assets/PEAKFocus.mp4)

# Technical Documentation
Please pay attention to the dependencies and follow the instructions below to build and run the application on your local machine. 

## Pre-requisites & Dependencies
We built **PEAKFocus** with [Flutter](https://flutter.dev/) and [Dart](https://dart.dev/). Please follow the [installation instructions](https://flutter.dev/docs/get-started/install) to set up your local development environment. We deliberatily developed **PEAKFocus** to be compatible with a wide range of neurofeedback devices. For the hackathon we used EEG caps provided by [brainboost](https://brainboost.de/en/) and transmitting software provided by them that precisely filters out brain activity from the raw EEG data. This filtered data stream can then be send to ou backend dataservice via tcp. For the application to function properly this data stream is required. 

## Project Structure
```bash 
.
├── assets                                          # Assets for GitHub
├── neuroapp                                        # Flutter project
│   ├── analysis_options.yaml
│   ├── android
│   ├── assets
│   ├── build
│   ├── ios
│   ├── lib                                         # Main application folder
│   │   ├── main.dart
│   │   ├── services                                # Backend services
│   │   └── views                                   # Frontend views
│   ├── pubspec.lock
│   ├── pubspec.yaml
│   └── test
└── README.md
```

## Build & Run Instructions
1. Clone the repository
   ```bash
    git clone https://github.com/StartHack-PSFO/PeakFocus.git
    ```
2. Open project and get dependencies
   ```bash
    cd PeakFocus/neuroapp
    flutter pub get
    ```
3. Connect an Android or iOS devie to your computer and run the app
    ```bash
    flutter run
    ```
