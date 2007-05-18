From: "Adrian McMenamin" <adrianmcmenamin@gmail.com>
Subject: submitting a patch against the ALSA repos
Date: Fri, 18 May 2007 10:16:26 +0100
Message-ID: <92a12cdb0705180216k4bb70a64x7da9c03313220623@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 698102452C
	for <alsa-devel@alsa-project.org>;
	Fri, 18 May 2007 11:16:31 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c18so221452anc
	for <alsa-devel@alsa-project.org>; Fri, 18 May 2007 02:16:29 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have submitted my patch against the 2.6.21 kernel tree but I dare
say I need to actually submit it against the alsa repos.

I have a few questions:

1. Which set of sources do I patch - I assume alsa-driver - is that right?

2. How do I patch the firmware repo? As it is a binary I assume it is
by some means other than patch(1)

3. This is a new architecture - there are no other SuperH drivers in
alsa (afaik) - how do I add a new architecture? My memory is that when
I tried this a year ago it was a bit of a nightmare.
