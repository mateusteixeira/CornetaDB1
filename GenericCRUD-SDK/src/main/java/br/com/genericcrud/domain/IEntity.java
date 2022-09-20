package br.com.genericcrud.domain;

import java.io.Serializable;

@FunctionalInterface
public interface IEntity<T extends Serializable> {
    T getId();
}
