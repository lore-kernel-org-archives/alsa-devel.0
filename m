From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: Si3054 and Lenovo3000 n100
Date: Sun, 13 Jan 2008 19:10:44 +0200
Message-ID: <200801131910.44911.anarsoul@gmail.com>
References: <200801131649.46091.anarsoul@gmail.com>
	<20080113161506.GD2097@serv.smile.org.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 91C542498D
	for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2008 18:11:05 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so1848598fgb.44
	for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2008 09:11:05 -0800 (PST)
In-Reply-To: <20080113161506.GD2097@serv.smile.org.ua>
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
To: Andy Shevchenko <andy@smile.org.ua>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 13 January 2008 18:15:06 Andy Shevchenko wrote:
> Hi Vasily Khoruzhick!
>
>  On Sun, Jan 13, 2008 at 04:49:45PM +0200, Vasily Khoruzhick wrote next:
> > Hi, I have problems with setting up internal modem (regular si3054
> > sitting on hda bus) with subj notebook.
>
> Do you belive that the Si3054 clone? What is ids of your modem codec?
> If you get 11c1:1040 you lose this game.
>
> P.S. IIRC the n200 has unsupported modem codec. I guess your model too.

Btw, if it isn't compatible with Si3054, why its id added to patch_si3054.c 
file?

Regards
Vasily
