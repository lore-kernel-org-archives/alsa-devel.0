From: "`/ET!-i1S!-i" <yethish7@gmail.com>
Subject: Copy ALSA buffer to the buffer allocated in my driver.
Date: Tue, 2 Aug 2011 17:33:40 +0530
Message-ID: <CAB+ez9v=4FQRRsNLoc+=kvJ3ivd4pEEgR+ZoagPrR4mGaAHcKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BD4C5103857
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Aug 2011 14:03:42 +0200 (CEST)
Received: by fxh10 with SMTP id 10so5994727fxh.38
	for <alsa-devel@alsa-project.org>; Tue, 02 Aug 2011 05:03:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

I am writing my own alsa driver for playback application.1. I have no idea
how to copy the alsa buffer to intermediate buffer (my Buffer) .
2.  I have taken dummy driver code as example.
3. Can anyone help me. What code has to be included in the dummy driver to
copy alsa buffer to intermediate buffer.

Regards

      Cherry
