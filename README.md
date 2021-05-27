# Resort Feedback Application

## Project Description
Resort Feedback Application collects the feedback from the customers about their stay experience with the resort to make improvements in the services. Each user first needs to sign up to provide feedback.

## Technologies Used
1. XCode - Version 12.5
1. Swift - Version 5.0

## Features

#### List of features ready:
1. User can create an account.
2. User can reset their password if they forgot.
3. User can log in and answer feedbacks.
4. User can delete their account if needed
5. User can obtain coupon codes depending on which feedback they finished.
6. User can only complete one feedback per category. 
 
#### To-do list:
1. Add a timer where User can resubmit a feedback after a certain time.
2. Add a secure way to reset password.

## Getting Started:
To get a copy of this project, we can clone this project via Terminal or XCode. I will show you both methods.

### Cloning via Terminal
Go to your terminal and go to the directory where you want this project to be saved.

Once you are in the location where you want this project to be saved, copy this line and paste it on your terminal 
```
git clone https://github.com/guilmeister/Feedback-App
```

### Cloning via XCode
Once you open XCode you will see this screen
 
![Images](/Images/ExampleXCodeStart.png)
 
Click on the Clone an Existing Project option and you will see this next screen
 
![Images](/Images/ExampleXCodeClone.png)
 
Click the search bar and copy this line and paste it on the search bar
```
 git clone https://github.com/guilmeister/Feedback-App
```

## Usage
Once you run the application, a loading screen will appear for 5 seconds and automatically takes you to the Sign In screen.

![Images](/Images/ExampleLoad.png)

From here you can Sign In if you have an existing account or click the Sign Up Here button on the lower right side of the Sign In screen if you don't have an account.

![Images](/Images/ExampleSignIn.png)

If you have an existing account but forgot your password, simply enter your Username, the new Password, and repeat the new password on their respective text fields.

![Images](/Images/ExampleReset.png)

Once you Sign In and it is verified, you are taken to the Home Screen where the user have a few options to take. The user can take 5 different feedback categories, manage your account, or log out.

![Images](/Images/ExampleMenu.png)

When you pick a feedback to answer you are taken to that respective feedback questionnaire and go back automatically after you have finished answering.

![Images](/Images/ExampleFeedback.png)

When you press on the Manage Account button, you are taken to the Manage Account screen where you can see your coupon codes for finishing a certain feedback and can either update their password or delete their account.

![Images](/Images/ExampleMyAccount.png)

When you press on the Update Password button, you are taken to a similar screen as the Forgot Password screen. On this screen you just have to specify what your new password is and repeat it for the other text field.

![Images](/Images/ExampleUpdate.png)

When you press on the Delete Account, it shows a prompt if you are really sure of deleting your account and if you confirm, it will delete the current account from Core Data and switches the screen back to the Sign In screen.

![Images](/Images/ExampleDelete.png)

## License
