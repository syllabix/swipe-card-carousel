//
//  IndcatorIconType.swift
//  SwipeCardCarousel
//
//  Created by Tom Stoepker on 10/15/16.
//  Copyright © 2016 CrushOnly. All rights reserved.
//

public enum IndicatorIconType {
	case chevron, arrow
	
	var icon: IndicatorIcon {
		switch self {
		case .chevron:
			return Chevron()
		case .arrow:
			return Arrow()
		}
	}
}
