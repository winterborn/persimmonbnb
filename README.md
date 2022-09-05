# persimmonbnb

# High-Level Project Description:

# MakersBnB specification

We would like a web application that allows users to list spaces they have available, and to hire spaces for the night.

### Headline specifications

- Any signed-up user can list a new space.
- Users can list multiple spaces.
- Users should be able to name their space, provide a short description of the space, and a price per night.
- Users should be able to offer a range of dates where their space is available.
- Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
- Nights for which a space has already been booked should not be available for users to book that space.
- Until a user has confirmed a booking request, that space can still be booked for that night.

### Nice-to-haves

- Users should receive an email whenever one of the following happens:
- They sign up
- They create a space
- They update a space
- A user requests to book their space
- They confirm a request
- They request to book a space
- Their request to book a space is confirmed
- Their request to book a space is denied
- Users should receive a text message to a provided number whenever one of the following happens:
- A user requests to book their space
- Their request to book a space is confirmed
- Their request to book a space is denied
- A ‘chat’ functionality once a space has been booked, allowing users whose space-booking request has been confirmed to chat with the user that owns that space
- Basic payment implementation though Stripe.

### Mockups

Mockups for MakersBnB are available [here](https://github.com/makersacademy/course/blob/main/makersbnb/makers_bnb_images/MakersBnB_mockups.pdf).

# User Stories:

### Any signed-up user can list a new space.

As a User;
So that I can be a host and/or a guest
I want to sign up for MakersBnB.

As a User;
So that I can list a new space,
I want to create a new space on MakersBnB.

### Users can list multiple spaces.

As a User;
So that I can list multiple spaces,
I want to list all created spaces.

### Users should be able to name their space, provide a short description of the space, and a price per night.

As a User;
So that I can give details to my space,
I want to add a name to my space.

As a User;
So that I can give details to my space,
I want to add a short description to my space.

As a User;
So that I can give details to my space,
I want to add a price per night to my space.

### Users should be able to offer a range of dates where their space is available.

As a User;
So that I can offer a range of available dates for booking,
I want to list available dates.

### Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.

As a Customer;
So that I can book a space,
I want to view all available spaces.

As a Customer;
So that I can book a space,
I want to filter spaces available for specific dates.

As a Customer;
So that I can book a space,
I want to request a booking based on date.

As an Owner;
So that I can see a booking request,
I want to view all booking requests.

As an Owner;
So that I can approve a booking request,
I want to confirm or deny a booking.

### Nights for which a space has already been booked should not be available for users to book that space.

As a Customer;
So that I do not see booked spaces,
I want to view only available spaces.

### Until a user has confirmed a booking request, that space can still be booked for that night.

As an Owner;
Until I confirm a booking,
My space is still shown as available.

As an Owner;
Until I confirm a booking,
My space can still accept booking requests.
