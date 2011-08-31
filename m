From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH utils] Fix use of $(SED).
Date: Wed, 31 Aug 2011 22:39:19 +0200
Message-ID: <4E5E9BF7.8060506@ladisch.de>
References: <1314808482-18242-1-git-send-email-mgorny@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 86149244B3
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Aug 2011 22:39:40 +0200 (CEST)
In-Reply-To: <1314808482-18242-1-git-send-email-mgorny@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc: alsa-devel@alsa-project.org, alsa-bugs@gentoo.org
List-Id: alsa-devel@alsa-project.org

TWljaGHFgiBHw7Nybnkgd3JvdGU6Cj4gVGhlIGFsc2FjdGwgTWFrZWZpbGUgdXNlZCAnc2VkICQo
U0VEKScgd2hpY2ggaXMgZ29pbmcgdG8gZmFpbGVkIHdoZW4gU0VECj4gaXMgYWN0dWFsbHkgc2V0
LiBSZXBsYWNlZCB0aGF0IHdpdGggJyQoU0VEKScsIGFuZCBhIGZldyAnc2VkJyBjYWxscyBpbgo+
IGFsc2Fjb25mIE1ha2VmaWxlIGFzIHdlbGwuIEFkZGVkIEFDX1BST0dfU0VEIHRvIGNvbmZpZ3Vy
ZSB0byBoYXZlIGl0Cj4gc2V0Lgo+Cj4gRml4ZXM6IGh0dHBzOi8vYnVndHJhY2suYWxzYS1wcm9q
ZWN0Lm9yZy9hbHNhLWJ1Zy92aWV3LnBocD9pZD01MzYzCj4gRml4ZXM6IGh0dHA6Ly9idWdzLmdl
bnRvby5vcmcvc2hvd19idWcuY2dpP2lkPTM2NjU4Nwo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhxYIg
R8Ozcm55IDxtZ29ybnlAZ2VudG9vLm9yZz4KCkFwcGxpZWQsIHRoYW5rcyEKCgpDbGVtZW5zCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5h
bHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
