# Travel Logistics and Supplier Management

This project contains only the company logistics module. Customers do not book services here. Staff create trip departures and allocate supplier services to them.

## Run in IntelliJ
1. Open the `travelmanagement` folder as a Maven project. Use JDK 17 or newer.
2. In MySQL Workbench, run `Database/TravelLogistics.sql`.
3. Set the `DB_PASSWORD` environment variable in the IntelliJ run configuration to your MySQL root password. The connection uses `travel_logistics_db` on localhost:3306.
4. Run `TravelmanagementApplication`.
5. Open http://localhost:8081/logistics in Safari.

The original Spring Boot version and Maven dependencies are retained. Terminal alternative: `chmod +x mvnw` then `./mvnw spring-boot:run` from `travelmanagement` with `DB_PASSWORD` set.

## Separate pages
- Departures: create a trip with a unique reference, package, destination, and start/end dates.
- Suppliers: enter hotel, transport, or guide/driver agencies and contracts.
- Hotels: allocate rooms and view hotel allocations.
- Transport: allocate flights, coaches, trains, or vehicles.
- Guides & Drivers: register staff and daily rates.
- Assignments: assign staff to a trip and view calculated costs.
- Payments: record payments already made to suppliers.
- Departure Costs: see total supplier cost, paid amount, and outstanding amount.

Each form stays on its own page after saving or validation errors. Navigation and Continue links open separate pages. Existing blue layout, forms, and table styling are preserved.

## Validation
Trip references must be unique; end dates cannot precede start dates. Service dates must fall within trip dates and supplier contracts. Hotel check-out must follow check-in and room capacity is checked. A vehicle/service reference cannot be allocated twice for the same supplier/date. Staff assignments cannot overlap. Costs cannot be negative, seats/rooms must be positive, and payments cannot exceed the supplier's outstanding cost for that trip.

## Existing data
This copy uses a new database, `travel_logistics_db`. It does not delete or migrate your old flight/booking/logistics records in `travel_management_db`. Add trip departures and supplier records through the pages. Airline booking, carts, tickets, and customer payments have been removed from this project.

For group integration, trip departures are the logistics parent records. The standalone module uses `departure_id` instead of the earlier `flight_id`; teammates must use that association when integrating.

## Verification note
The eight page templates, navigation links, form actions, redirects, and departure references were checked. A full Maven build and live MySQL run could not be completed in the editing environment because Maven Central was unreachable and the Spring Boot dependencies were not cached. Run the project locally to verify database connectivity and the full workflow.
