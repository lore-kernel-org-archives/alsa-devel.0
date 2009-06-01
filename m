From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Subject: ASoC: TWL4030 driver support multi channel playback
Date: Mon, 1 Jun 2009 19:50:01 +0530
Message-ID: <ef0d8a250906010720n144bb53bl4c6cc3e79e0f8db9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FEDC24509
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Jun 2009 16:20:02 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so4057972qwk.56
	for <alsa-devel@alsa-project.org>; Mon, 01 Jun 2009 07:20:01 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Hi Peter,

I am using linux 2.6.28 kernel,

there is a requirement to support multi (4) channel play back .

I guess TWL4030 ASoC driver now has full fledged support for both the
DAC1(TX1) and  DAC2(TX2) paths
in option 1 of codec operation.

I am looking forward to back port the ASoC stuff drivers from 2.6.30 rc7  to
2.6.28.

Is there any better way of meeting the requirement with out back porting the
stuff

Suggestions please.

Sorry for the english,,
-- 
Cheers
(: Naveen Krishna Ch :)
