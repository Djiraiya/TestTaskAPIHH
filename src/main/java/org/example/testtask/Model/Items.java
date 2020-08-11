package org.example.testtask.Model;

import com.fasterxml.jackson.annotation.*;

import java.util.List;


@JsonIgnoreProperties
public class Items {

    private List<Vacansy> items;

    private int pages;

    public List<Vacansy> getItems() {
        return items;
    }

    public void setItems(List<Vacansy> items) {
        this.items = items;
    }

    public int getPages() {
        return pages;
    }

    public void setPages(int pages) {
        this.pages = pages;
    }

    @Override
    public String toString() {
        return "Items{" +
                "itemsList=" + items +
                '}';
    }
}
