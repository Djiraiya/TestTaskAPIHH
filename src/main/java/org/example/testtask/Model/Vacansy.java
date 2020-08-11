package org.example.testtask.Model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


import javax.persistence.*;

@JsonIgnoreProperties
//@JsonRootName("items")
@Entity
@Table(name = "vacansy")
public class Vacansy {

    @Id
    private int id;

    private String name;
    private String published_at;

    private int specializationId;
    private int areaId;

    @Embedded
    private Employers employer;

    @Embedded
    private Salary salary;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPublished_at() {
        return published_at;
    }

    public void setPublished_at(String published_at) {
        this.published_at = published_at.split("T")[0];
    }

    public Employers getEmployer() {
        return employer;
    }

    public void setEmployer(Employers employer) {
        this.employer = employer;
    }

    public Salary getSalary() {
        return salary;
    }

    public void setSalary(Salary salary) {
        this.salary = salary;
    }

    public int getSpecializationId() {
        return specializationId;
    }

    public void setSpecializationId(int specializationId) {
        this.specializationId = specializationId;
    }

    public int getAreaId() {
        return areaId;
    }

    public void setAreaId(int areaId) {
        this.areaId = areaId;
    }

    @Override
    public String toString() {
        return "Vacansy{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", published_at='" + published_at + '\'' +
                ", employer=" + employer +
                ", salary=" + salary +
                '}';
    }
}

