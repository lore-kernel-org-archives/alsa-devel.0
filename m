From: Justin Turner Arthur <justinarthur.mail@verizon.net>
Subject: Re: Re: ice1712 driver broken in 2.6.1-mm kernels
Date: Wed, 21 Jan 2004 01:42:21 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <400E1F4D.9040202@verizon.net>
References: <1074633766.6579.2.camel@moria.arnor.net>	 <Pine.LNX.4.58.0401202308390.2010@pnote.perex-int.cz> <1074637277.6579.16.camel@moria.arnor.net> <400DB759.2010807@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from out003.verizon.net (out003pub.verizon.net [206.46.170.103])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id HAA06855
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2004 07:40:31 +0100
Received: from verizon.net ([151.199.95.62]) by out003.verizon.net
          (InterMail vM.5.01.06.06 201-253-122-130-106-20030910) with ESMTP
          id <20040121064028.UMMW24306.out003.verizon.net@verizon.net>
          for <alsa-devel@alsa-project.org>;
          Wed, 21 Jan 2004 00:40:28 -0600
In-Reply-To: <400DB759.2010807@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Steffen Sauder wrote:

> Torrey Hoffman wrote:
>
>> In 2.6.1-mm5, which I'm running at the moment, I just get no sound
>> output.  No error messages.  The envy24control level meters don't show
>> any sound output.
>>  
>>
> I have the same problem with my Terratec DMX6fire, running gentoo / 
> 2.6.1 with the alsa-kernel directory from alsa-driver-1.0.1 merged 
> into the kernel sources as described in the wiki. Sometimes  I hear 
> some kind of looped noise instead of silence which stays the same no 
> matter what I try to play.
>
I'm getting this nasty looped noise as well using a M-Audio Delta 1010lt 
with alsa 1.0.1 merged into kernel 2.6.1

This also occured using Alsa 1.0.0rc2.

This is definetely an annoying bug.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
