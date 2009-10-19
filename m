From: Dominik Zalewski <dominikz@genijusz.org>
Subject: patchmix application for EMU1616m
Date: Mon, 19 Oct 2009 09:31:47 +0200
Message-ID: <8282c2500910190031x3c65a3d4je5d77fb1c66b1dab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 66CBA24434
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Oct 2009 09:32:08 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 3so877142eyh.16
	for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2009 00:32:07 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

Is there anybody working on patchmix application for alsa?
I'm wondering what would be the guidelines.
- Should it be a clone of a patchmix for Windows: a separate program?
- Or maybe there is already some infrastructure in Alsa that should be
extended with that functionality?
- Alsamixer already has some of that functionality, should be
replicated in new patchmix application?
- Are there any restrictions for the GUI libraries that may be used?
- Does it have to be written in C/C++, or is Java also applicable?

-- 
Dominik Zalewski
