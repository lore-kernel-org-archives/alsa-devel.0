From: Alex Leach <beamesleach@gmail.com>
Subject: Re: Asus Xonar DG front panel not working
Date: Thu, 17 May 2012 11:20:17 +0000 (UTC)
Message-ID: <loom.20120517T131540-150@post.gmane.org>
References: <CAJZVDJAO9EBeyuHHAhKfWdej=FzfrzCx0bf33rELWqBnNobTHQ@mail.gmail.com>
	<4FA91813.2050604@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 1258E2412D
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2012 13:25:11 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1SUypL-0002fi-Aw
	for alsa-devel@alsa-project.org; Thu, 17 May 2012 13:25:03 +0200
Received: from wc10.york.ac.uk ([144.32.128.14])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 17 May 2012 13:25:03 +0200
Received: from beamesleach by wc10.york.ac.uk with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 17 May 2012 13:25:03 +0200
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

Clemens Ladisch <clemens <at> ladisch.de> writes:

> 
> Marcos Felipe Rasia de Mello wrote:
> > My Asus Xonar DG doesn't play through FP Headphone connector (HD
> > Audio). Mic input doesn't work too (both rear and front connectors).
> 
> These are known bugs.  They will not be fixed until I find the time
> to do more reverse engineering to find out how the hardware works.
> 
> Regards,
> Clemens
> 

Reverse engineering sounds like no easy task, but you've done an excellent job
so far! I'm getting the same lack of front headphone support on a Xonar HDAV
1.3, and am hoping the same fix will work for both cards.
Good luck with the reverse engineering (and finding the time to do it)!
Kind regards,
Alex
