From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: finally, ALSA 1.0.24 is out
Date: Mon, 31 Jan 2011 23:52:13 +0000
Message-ID: <ii7hvd$h4t$3@dough.gmane.org>
References: <alpine.LNX.2.00.1101311605240.6272@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 33BB624396
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 00:55:06 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Pk3aK-0003iR-W8
	for alsa-devel@alsa-project.org; Tue, 01 Feb 2011 00:55:05 +0100
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 01 Feb 2011 00:55:04 +0100
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 01 Feb 2011 00:55:04 +0100
In-Reply-To: <alpine.LNX.2.00.1101311605240.6272@eeebox2.perex-int.cz>
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

'Twas brillig, and Jaroslav Kysela at 31/01/11 15:16 did gyre and gimble:
> Hello all,
> 
>  	after very intensive testing, I released all ALSA packages with 
> version number 1.0.24(+) :
> 
>      * alsa-driver-1.0.24
>      * alsa-lib-1.0.24.1
>      * alsa-utils-1.0.24.2
>      * alsa-tools-1.0.24
>      * alsa-firmware-1.0.24
>      * alsa-plugins-1.0.24
>      * pyalsa-1.0.24
> 
>  	The full list of changes is here:
> 
> http://www.alsa-project.org/main/index.php/Changes_v1.0.23_v1.0.24
> 
>  	There is a ton of work in these parts (among others):
> 
> * alsa-driver
>    - HDA driver
>    - ASoC tree
>    - USB driver
> * alsa-library
>    - Use Case Manager
> * alsa-utils
>    - alsaloop and alsaucm introduction
>    - alsactl improvements
> * alsa-tools
>    - updated hdspmixer
> 
>  	Please, report compilation problems directly to me or to the 
> alsa-devel mailing list.


Good work! Lots of nice fixes in here :)

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
