package com.monami.dto;

import lombok.Data;

@Data
public class kakaoProfile {
	private String id;
	private KakaoAccount kakao_account;
	
		@Data
		public class KakaoAccount {
		private Profile profile;
		private String email;
		private boolean has_email;

			@Data
			public class Profile {
			private String nickname;
			private String profile_image_url;
		}
	}
}
