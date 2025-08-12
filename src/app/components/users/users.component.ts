import { Component } from '@angular/core';
import { MatTableModule } from '@angular/material/table';

@Component({
  selector: 'app-users',
  imports: [MatTableModule],
  templateUrl: './users.component.html',
  styleUrl: './users.component.css'
})
export class UsersComponent {
displayedColumns: string[] = ['id', 'firstName', 'lastName', 'email', 'role'];
dataSource = [
  {
    id: '123',
    firstName: 'John',
    lastName: 'Doe',
    email: 'email@example.com',
    role: 'ADMIN'
  }
];
}
