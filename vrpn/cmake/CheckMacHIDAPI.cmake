# - Script to check if the signature for a mac HID callback uses UInt32 or uint32_t
# Requires that the associated CPP file be present in ${CMAKE_CURRENT_SOURCE_DIR}/cmake/CheckMacHIDAPI.cpp.
#
#	MACOSX_HID_UINT32T, set according to the results of our test.
#
# 2009 Ryan Pavlik <rpavlik@iastate.edu>
# http://academic.cleardefinition.com
# Iowa State University HCI Graduate Program/VRAC


if(APPLE)
	if(NOT MACOSX_HID_UINT32T)
		try_compile(_HID_uint32t ${CMAKE_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/cmake/CheckMacHIDAPI.cpp
					OUTPUT_VARIABLE _HID_uint32t_OUTPUT
					COMPILE_DEFINITIONS -DMACOSX_HID_UINT32T=uint32_t)
		message(STATUS "Checking uint32_t in HID callback signature... ${_HID_uint32t}")
		
		try_compile(_HID_UInt32 ${CMAKE_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/cmake/CheckMacHIDAPI.cpp
					OUTPUT_VARIABLE _HID_UInt32_OUTPUT
					COMPILE_DEFINITIONS -DMACOSX_HID_UINT32T=UInt32)
		message(STATUS "Checking UInt32 in HID callback signature... ${_HID_UInt32}")


		if(_HID_uint32t)
			set(MACOSX_HID_UINT32T "uint32_t" CACHE STRING
				"The 32-bit uint type desired in the callback set by setInterruptReportHandlerCallback")
			mark_as_advanced(MACOSX_HID_UINT32T)
		elseif(_HID_UInt32)
			set(MACOSX_HID_UINT32T "UInt32" CACHE STRING
				"The 32-bit uint type desired in the callback set by setInterruptReportHandlerCallback")
			mark_as_advanced(MACOSX_HID_UINT32T)
		else()
			message(SEND_ERROR
				"ERROR: Could not detect appropriate Mac HID uint32 type!")
		endif()

	endif()
endif()