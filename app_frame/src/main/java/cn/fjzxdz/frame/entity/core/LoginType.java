package cn.fjzxdz.frame.entity.core;

import cn.fjzxdz.frame.entity.AlEntity;

public enum LoginType implements AlEntity {
    EMPTY {
        public String toString() {
            return "";
        }
    },
    SYSTEM {
        @Override
        public String toString() {
            return "system";
        }
    },
    CUSTOMER {
        @Override
        public String toString() {
            return "customer";
            
        }
    },
    SUPPLIER {
        @Override
        public String toString() {
            return "supplier";
        }
    };
    
   public abstract String toString();
}