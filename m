From: Jack Byer <ftn768@gmail.com>
Subject: Re: snd_hda_intel error
Date: Sat, 4 Dec 2010 07:38:57 -0600
Message-ID: <AANLkTimUryfsGeiuiATCeBoeFjKqYkJYabqR6+Fj1u5x@mail.gmail.com>
References: <AANLkTik8eGoD1WfJvLZtzWQ-6W=WkjxtQHjJsZ4WN9DX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id 223D92453D
	for <alsa-devel@alsa-project.org>; Sat,  4 Dec 2010 14:38:58 +0100 (CET)
Received: by qwj8 with SMTP id 8so5222959qwj.38
	for <alsa-devel@alsa-project.org>; Sat, 04 Dec 2010 05:38:57 -0800 (PST)
In-Reply-To: <AANLkTik8eGoD1WfJvLZtzWQ-6W=WkjxtQHjJsZ4WN9DX@mail.gmail.com>
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

I neglected to include this line from dmesg

hda-intel: IRQ timing workaround is activated for card #1. Suggest a
bigger bdl_pos_adj.

I don''t know if that is related or not.
