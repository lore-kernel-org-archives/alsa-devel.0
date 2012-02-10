From: Lieven Moors <lievenmoors@gmail.com>
Subject: Re: system announce port documentation
Date: Fri, 10 Feb 2012 17:56:48 +0100
Message-ID: <20120210165647.GC2949@studio>
References: <20120210134216.GA2949@studio>
 <4F35316A.6030709@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f193.google.com (mail-wi0-f193.google.com
	[209.85.212.193])
	by alsa0.perex.cz (Postfix) with ESMTP id E018210407D
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2012 17:57:30 +0100 (CET)
Received: by wibhq12 with SMTP id hq12so275134wib.8
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2012 08:57:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F35316A.6030709@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 10, 2012 at 04:02:02PM +0100, Clemens Ladisch wrote:
> Lieven Moors wrote:
> > I have been searching in vain for info or examples on how
> > to use the system announce port of alsa sequencer.
> 
> This port sends events when client or ports are created/
> removed/changed.  Use aseqdump to see what gets sent.
> 
> 
> Regards,
> Clemens


Thanks, the source of aseqdump is the example I was looking for.

Greetings,

Lieven
