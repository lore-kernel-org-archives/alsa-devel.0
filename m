From: Andrew Reyes <dsreyes1014@gmail.com>
Subject: Behringer Uphoria UMC204 usb audio capture only pops
	and clicks
Date: Tue, 15 Apr 2014 20:44:31 -0500
Message-ID: <CAEYsuVP4vq+W6ydTyqRtAZ62UOkAFsB87kBv+HnX72rNP+LGeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f42.google.com (mail-qa0-f42.google.com
 [209.85.216.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C849260859
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 03:44:32 +0200 (CEST)
Received: by mail-qa0-f42.google.com with SMTP id k15so10313895qaq.1
 for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2014 18:44:31 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have a usb Behringer Uphoria UMC204 and it seems to work fine at 44.1khz
full duplex but anything higher than that I get consistent pops and
clicks.  I notice it's on the capure side of things as when I have it in
playback only it's quiet. I have to say I'm testing this using JACK so this
is how I noticed it on the capture only side of things. I'm not sure
exactly whats needed to debug this issue. Any help would be appreciated.
Thanks in advance.
