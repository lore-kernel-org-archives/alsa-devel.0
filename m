From: Hans Schou <linux@schou.dk>
Subject: Re: PROBLEM: SIS7019 stops recording after 42 min
Date: Wed, 23 Jun 2010 20:26:29 +0200
Message-ID: <AANLkTilBXYuvPWUeCVcA9YIulLDxT91vpCq6b4TrAL41@mail.gmail.com>
References: <AANLkTimO5PXmJiIPDw82MTA53mLSl-OC0e1SOEh7v8pH@mail.gmail.com>
	<1276972298.22889.16.camel@obelisk.thedillows.org>
	<AANLkTimwZFNLBNJWODyzKXwx9CbIorg3OCA53XZchkeN@mail.gmail.com>
	<1277043970.22889.45.camel@obelisk.thedillows.org>
	<AANLkTikBTMq3d-Ov65wYLJ_Vw-7Jde4AOwfXcEPB0wLr@mail.gmail.com>
	<1277129180.22889.64.camel@obelisk.thedillows.org>
	<AANLkTikW71h7ABVXY21pLL9AeOlmRTfVaSTjJ_6Ma0_R@mail.gmail.com>
	<AANLkTikCGzUKe9Fy1d0xhberqGFe71lvrQbg5gkQzgf1@mail.gmail.com>
	<AANLkTikPW9j4H15gq7nl0Tb213R15uIQAnSDi_cTOJre@mail.gmail.com>
	<1277262047.10818.9.camel@obelisk.thedillows.org>
	<1277271419.10818.22.camel@obelisk.thedillows.org>
	<AANLkTiln40Xo3fHbMSkEvdBUtFq8ZWrF57wgRWdU2Juc@mail.gmail.com>
Reply-To: linux@schou.dk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DC44510391E
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 20:26:49 +0200 (CEST)
Received: by wwf26 with SMTP id 26so430930wwf.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 11:26:49 -0700 (PDT)
In-Reply-To: <AANLkTiln40Xo3fHbMSkEvdBUtFq8ZWrF57wgRWdU2Juc@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Dillow <dave@thedillows.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

2010/6/23 Hans Schou <linux@schou.dk>:

> If the problem is ALSA, how can I then turn it off?

I am quite sure it is turned off:

# dmesg | grep -A 1 ALSA
ALSA device list:
  No soundcards found.

regards/hans
