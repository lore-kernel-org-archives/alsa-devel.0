From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: alsa driver problem (snd_via82xx)
Date: Wed, 09 Aug 2006 16:43:55 -0400
Message-ID: <1155156235.26338.196.camel@mindpipe>
References: <97c31bd80608091159h40db8bc2l891cab8ddf7165ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751366AbWHIUoA@vger.kernel.org>
In-Reply-To: <97c31bd80608091159h40db8bc2l891cab8ddf7165ef@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Celary <bartlomiej.celary@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-08-09 at 20:59 +0200, Bartlomiej Celary wrote:
> Hello,
> 
> I am having a problem with alsa driver. It is not a big issue, but a
> significant drawback...
> Ive used the form, so here it is.
> 
> [1.] One line summary of the problem:
> While using snd_via82xx the PCM volume is not responding to changing
> Master Volume.

This should be reported to the ALSA bug tracker (or alsa-devel mailing
list if you can help fix the code), not LKML:

https://bugtrack.alsa-project.org/alsa-bug/bug_report_advanced_page.php

Lee
