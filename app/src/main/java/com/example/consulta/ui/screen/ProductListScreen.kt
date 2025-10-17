package com.example.consulta.ui.screen

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import com.example.consulta.model.Product
import java.text.NumberFormat
import java.util.Locale

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ProductListScreen() {
    val products = getProductList()

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Produtos") },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = MaterialTheme.colorScheme.primary,
                    titleContentColor = MaterialTheme.colorScheme.onPrimary
                )
            )
        }
    ) { paddingValues ->
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues),
            contentPadding = PaddingValues(16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            items(products) { product ->
                ProductCard(product = product)
            }
        }
    }
}

@Composable
fun ProductCard(product: Product) {
    Card(
        modifier = Modifier.fillMaxWidth(),
        elevation = CardDefaults.cardElevation(defaultElevation = 4.dp)
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp)
        ) {
            Text(
                text = product.name,
                style = MaterialTheme.typography.titleMedium,
                fontWeight = FontWeight.Bold
            )
            Spacer(modifier = Modifier.height(8.dp))
            Text(
                text = product.description,
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
            Spacer(modifier = Modifier.height(8.dp))
            Text(
                text = formatPrice(product.price),
                style = MaterialTheme.typography.titleLarge,
                color = MaterialTheme.colorScheme.primary,
                fontWeight = FontWeight.Bold
            )
        }
    }
}

private fun getProductList(): List<Product> {
    return listOf(
        Product(1, "Notebook Dell", "Notebook com processador i7, 16GB RAM", 3499.99),
        Product(2, "Mouse Logitech", "Mouse sem fio com sensor óptico", 89.90),
        Product(3, "Teclado Mecânico", "Teclado mecânico RGB com switches azuis", 299.99),
        Product(4, "Monitor LG 24\"", "Monitor Full HD IPS 24 polegadas", 699.00),
        Product(5, "Headset Gamer", "Headset com som surround 7.1", 249.90),
        Product(6, "Webcam HD", "Webcam 1080p com microfone embutido", 199.00),
        Product(7, "SSD 480GB", "SSD SATA III com velocidade de leitura 550MB/s", 279.99),
        Product(8, "Cadeira Gamer", "Cadeira ergonômica com ajuste de altura", 899.00),
        Product(9, "Mesa para PC", "Mesa com suporte para monitor e teclado", 449.90),
        Product(10, "Hub USB 3.0", "Hub com 4 portas USB 3.0", 59.90)
    )
}

private fun formatPrice(price: Double): String {
    val format = NumberFormat.getCurrencyInstance(Locale("pt", "BR"))
    return format.format(price)
}

