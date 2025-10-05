/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.pw;

/**
 *
 * @author Fer_ITM
 */
public class item {
     private String Nombre;
    private double Precio;

    // Constructor para crear un nuevo item
    public item(String nombre, double precio) {
        this.Nombre = nombre;
        this.Precio = precio;
    }

    // Método para obtener el nombre
    public String getNombre() {
        return Nombre;
    }

    // Método para obtener el precio
    public double getPrecio() {
        return Precio;
    }
    
}
