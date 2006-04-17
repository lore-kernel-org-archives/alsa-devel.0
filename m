From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-devel] Re: [linuxsh-dev] [PATCH] ALSA driver for Yamaa
	AICA on Sega Dreamcast
Date: Mon, 17 Apr 2006 18:15:56 -0400
Message-ID: <1145312157.16138.87.camel@mindpipe>
References: <1145232784.12804.2.camel@localhost.localdomain>
	 <20060417012913.GA16821@linux-sh.org>
	 <1145304037.9244.27.camel@localhost.localdomain>
	 <1145310435.16138.83.camel@mindpipe> <20060417220512.GA16119@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751300AbWDQWQA@vger.kernel.org>
In-Reply-To: <20060417220512.GA16119@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>, Paul Mundt <lethal@linux-sh.org>, Alsa-devel <alsa-devel@lists.sourceforge.net>, linux-sh <linuxsh-dev@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-04-17 at 23:05 +0100, Christoph Hellwig wrote:
> On Mon, Apr 17, 2006 at 05:47:15PM -0400, Lee Revell wrote:
> > On Mon, 2006-04-17 at 21:00 +0100, Adrian McMenamin wrote:
> > > But I am happy to change it.
> > > 
> > > 
> > 
> > Please don't - when adding code to a subsystem with different
> > conventions than mainline the FAQ says to follow the subsystem
> > conventions.
> 
> Nope.  Alsa needs to gradually converted from something that looks like
> cat puke to normal kernel style.  Every new driver that's written properly
> helps.

OK thanks.  I was certain I saw this in the FAQ at some point but now I
can't find it.

Lee
