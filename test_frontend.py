import urllib.request
import urllib.error

def test_frontend():
    try:
        # Test if the frontend server is running on port 8001
        response = urllib.request.urlopen('http://localhost:8001')
        if response.getcode() == 200:
            print("Frontend server is running successfully!")
            print(f"Status: {response.getcode()}")
            print(f"Content type: {response.headers.get('Content-Type')}")
            
            # Read a small portion of the content
            content = response.read(200)  # Read first 200 bytes
            print(f"Content preview: {content[:100]}...")
            return True
        else:
            print(f"Unexpected status code: {response.getcode()}")
            return False
    except urllib.error.URLError as e:
        print(f"Failed to connect to frontend server: {e}")
        return False
    except Exception as e:
        print(f"Unexpected error: {e}")
        return False

if __name__ == "__main__":
    print("Testing Sudoku Solver Frontend...")
    success = test_frontend()
    if success:
        print("\n✓ Frontend is accessible at http://localhost:8001")
        print("Open your browser to use the Sudoku solver!")
    else:
        print("\n✗ Frontend is not accessible")
        print("Make sure the server is running with 'start_frontend.bat'")