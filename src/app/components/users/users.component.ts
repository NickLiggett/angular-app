import { Component } from '@angular/core';
import { MatTableModule } from '@angular/material/table';

@Component({
  selector: 'app-users',
  imports: [MatTableModule],
  templateUrl: './users.component.html',
  styleUrl: './users.component.css'
})
export class UsersComponent {
displayedColumns: string[] = ['id', 'firstName', 'lastName', 'username', 'email', 'role'];
dataSource = [
  {
    id: '123',
    firstName: 'John',
    lastName: 'Doe',
    username: 'john.doe',
    email: 'email@example.com',
    role: 'ADMIN',
  }
];
}
