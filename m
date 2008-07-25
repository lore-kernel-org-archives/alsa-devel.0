From: "Timur Tabi" <timur@freescale.com>
Subject: Re: alsa-lib has anyone ever looked at taking it cross
	platform?
Date: Fri, 25 Jul 2008 09:16:49 -0500
Message-ID: <ed82fe3e0807250716x330bfaeaqbd18e4d5f9865520@mail.gmail.com>
References: <e7d8f83e0807250049h60fabd30x295d739ee6f21e98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.225])
	by alsa0.perex.cz (Postfix) with ESMTP id A378A24338
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jul 2008 16:16:51 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 36so2273120wra.24
	for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2008 07:16:50 -0700 (PDT)
In-Reply-To: <e7d8f83e0807250049h60fabd30x295d739ee6f21e98@mail.gmail.com>
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
To: Peter Dolding <oiaohm@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 25, 2008 at 2:49 AM, Peter Dolding <oiaohm@gmail.com> wrote:
> This would kinda make logical sence.
>
> Alsa-lib plugin system in theory should be able to take any kind sound
> output under it.   Simplify development of all applications on top of
> it.  If alsa was cross platform why would you use something else as a
> middle body wrapper when you port.

Uniaud is a port of the ALSA kernel modules to OS/2.  It wouldn't be
too hard to add alsa-lib to that port.

http://uniaud.netlabs.org/en/site/index.xml

-- 
Timur Tabi
Linux kernel developer at Freescale
