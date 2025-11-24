/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.pw;

/**
 *
 * @author Fer_ITM
 */

public class Usuario {
    private int id;
    private String nombre;
    private String passwordHash;
    private String rol;

    public Usuario(int id, String nombre, String passwordHash, String rol) {
        this.id = id;
        this.nombre = nombre;
        this.passwordHash = passwordHash;
        this.rol = rol;
    }

    public int getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public String getRol() {
        return rol;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }
}
