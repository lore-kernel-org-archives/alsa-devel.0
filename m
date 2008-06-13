From: "Bruno Schneider" <boschneider@gmail.com>
Subject: input source selection not working (snd-hda-intel)
Date: Fri, 13 Jun 2008 20:48:29 -0300
Message-ID: <ae397f1b0806131648u47031ae5ke583795fdb330dbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 5496D24529
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Jun 2008 01:48:31 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so6426486wfg.23
	for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2008 16:48:29 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm using a computer with a ASUS P5LD2-X motherboard. The audio
controller, is a Realtek ALC662. I'm using an updated Debian Lenny
(testing) system.

No matter what I set as the input source, sound is always recorded
from the back microphone jack.

Before posting here, I tried to get help from my Debian list and from
the alsa-user list [1]. I'm starting to think this is a bug on the
snd-hda-intel module. Please help.

[1] http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg22667.html

-- 
Bruno Schneider
http://www.dcc.ufla.br/~bruno/
