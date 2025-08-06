# Flutter Appointment Booking System

This is a comprehensive Flutter implementation of the appointment booking system, replicating the functionality from the React/JSX version in the `lib/AppointmentBooking/` folder.

## Features

### 1. Step-by-Step Booking Process

- **Step 1: Select Doctor** - Browse and search through available doctors
- **Step 2: Choose Time** - Select date and time slot from doctor's schedule
- **Step 3: Book Appointment** - Confirm appointment details and add notes
- **Step 4: My Appointments** - View and manage existing appointments

### 2. Doctor Selection

- Search doctors by name, specialization, hospital, or clinic
- Filter by specialization
- View doctor details including contact information
- Responsive card-based layout

### 3. Schedule Management

- Calendar view for date selection
- Available time slots display
- Real-time slot availability (mock data for now)
- Intuitive time slot selection

### 4. Appointment Booking

- Appointment summary with all details
- Optional notes for the doctor
- Important information and guidelines
- Confirmation process with loading states

### 5. Appointment Management

- View all appointments with status badges
- Filter appointments by status (pending, confirmed, cancelled, completed)
- Sort by date, doctor name, or status
- Cancel appointments (with confirmation)
- Statistics dashboard

## File Structure

```
lib/views/patient/screens/
├── appointment_booking_screen.dart          # Main booking screen with step navigation
└── widgets/
    ├── doctor_list_widget.dart              # Doctor selection with search and filters
    ├── doctor_schedule_widget.dart          # Calendar and time slot selection
    ├── booking_form_widget.dart             # Appointment confirmation and notes
    └── my_appointments_widget.dart          # Appointment management and cancellation
```

## Key Components

### AppointmentBookingScreen

- Manages the overall booking flow
- Step indicator with navigation
- Error and success message handling
- State management for selected doctor and time slot

### DoctorListWidget

- Displays list of available doctors
- Search functionality
- Specialization filtering
- Doctor card with contact information

### DoctorScheduleWidget

- Calendar date picker
- Time slot grid
- Availability status
- Date navigation

### BookingFormWidget

- Appointment details summary
- Notes input with character limit
- Important information display
- Confirmation buttons

### MyAppointmentsWidget

- Appointment list with status badges
- Filtering and sorting options
- Statistics dashboard
- Cancellation functionality

## Models Used

- `GetDoctorModel` - Doctor information
- `Appointment` - Appointment data structure

## Integration

The appointment booking screen is integrated into the patient main screen and can be accessed through the bottom navigation bar.

## API Integration

The appointment booking system is now fully integrated with the backend APIs:

### API Endpoints Used:

1. **Get Doctors**: `GET /api/appointments/doctors/`

   - Used in `DoctorListWidget` via `GetDoctorsCubit`
   - Returns list of available doctors with their details

2. **Get Doctor Availability**: `GET /api/appointments/doctors/{id}/availability/`

   - Used in `DoctorScheduleWidget`
   - Returns available time slots for a specific doctor and date range
   - Includes fallback mock data if API is unavailable

3. **Book Appointment**: `POST /api/appointments/book/`

   - Used in `BookingFormWidget`
   - Creates a new appointment with doctor, date, time, and notes

4. **Get My Appointments**: `GET /api/appointments/my-appointments/`

   - Used in `MyAppointmentsWidget`
   - Returns list of user's appointments

5. **Cancel Appointment**: `DELETE /api/appointments/appointments/{id}/`
   - Used in `MyAppointmentsWidget`
   - Cancels a specific appointment

### Authentication:

- All API calls use Bearer token authentication
- Token is retrieved from SharedPreferences using `SharedPrefKeys.token`

## Styling

Uses the existing `ColorManager` for consistent theming:

- Primary color: `ColorManager.primary`
- Background: `ColorManager.background`
- Consistent card layouts and spacing

## Future Enhancements

1. **Push Notifications** - Appointment reminders and updates
2. **Video Consultations** - Integration with video calling
3. **Prescription Management** - View and manage prescriptions
4. **Payment Integration** - Handle appointment payments
5. **Multi-language Support** - Internationalization
6. **Offline Support** - Cache appointments for offline viewing
7. **Real-time Updates** - Live appointment status updates
8. **Advanced Scheduling** - Recurring appointments and availability management

## Usage

To use the appointment booking system:

1. Navigate to the patient main screen
2. Tap the "appointment" tab in the bottom navigation
3. Follow the step-by-step booking process
4. View and manage appointments in the "My Appointments" section

The system provides a smooth, intuitive experience for patients to book and manage their healthcare appointments.
