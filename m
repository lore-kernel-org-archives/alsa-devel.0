From: Jens Oliver John <lists@2ion.de>
Subject: Re: Persisting background noise on HDA Intel PCH
 (ALC3232)
Date: Wed, 7 Jan 2015 21:44:18 +0100
Message-ID: <20150107204418.GB10708@camelia.2ion.de>
References: <20141213221334.GA4350@camelia.2ion.de>
 <20141214141734.GC29554@camelia.2ion.de>
 <s5hfvci5kz9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wp254.webpack.hosteurope.de (wp254.webpack.hosteurope.de
 [80.237.133.23])
 by alsa0.perex.cz (Postfix) with ESMTP id B6E392651FC
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 21:44:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hfvci5kz9.wl-tiwai@suse.de>
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

On Sun, Dec 14, 2014 at 04:06:50PM +0100, Takashi Iwai wrote:
> Did you try 3.18 kernel?  There have been a few fixes regarding
> Realtek COEF setup, and your issue might be such one.

Today, I tried the 3.18 kernel (I am sorry for the delay). The noise actually
has gotten a little bit quieter but alas, is still very much hearable.

Here is the updated alsa-info output for this kernel:
  http://www.alsa-project.org/db/?f=67ddb2d27bb9ef6c4c990975e6400828c36577de

Thanks & Best regards,
Jens.
