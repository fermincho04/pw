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
     private String nombre;
    private double precio;

    // Constructor para crear un nuevo item
    public item(String nombre, double precio) {
        this.nombre = nombre;
        this.precio = precio;
    }

    // Método para obtener el nombre
    public String getNombre() {
        return nombre;
    }

    // Método para obtener el precio
    public double getPrecio() {
        return precio;
    }
    
}
