From: Thor Kristoffersen <thorkr@gmail.com>
Subject: Re: [Alsa-user] Creative Sound Blaster X-Fi Titanium
 PCIe support
Date: Mon, 04 Oct 2010 19:12:30 +0200
Message-ID: <m2mxqtvq4h.fsf@getmail.no>
References: <AANLkTik5Xtk1SP72qOgVaAJfvytZE=Nz+ifo7VXcUcuJ@mail.gmail.com>
	<4CA5894E.1030907@ladisch.de> <m2lj6hx13x.fsf@getmail.no>
	<20101001204054.28d16bd4@symphony.aura-online.co.uk>
	<m2hbh5wsi8.fsf@getmail.no> <4CA976B3.9090009@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.getmail.no (smtp.getmail.no [84.208.15.66])
	by alsa0.perex.cz (Postfix) with ESMTP id 110181038C4
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Oct 2010 19:12:32 +0200 (CEST)
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
	by get-mta-out01.get.basefarm.net
	(Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20
	2008))
	with ESMTP id <0L9R00JVYZSUCH60@get-mta-out01.get.basefarm.net> for
	alsa-devel@alsa-project.org; Mon, 04 Oct 2010 19:12:30 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
	(localhost.localdomain [127.0.0.1])	by localhost (Email Security
	Appliance)
	with SMTP id 90F1E17991D5_CAA0AFEB	for <alsa-devel@alsa-project.org>;
	Mon, 04 Oct 2010 17:12:30 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
	with ESMTP id 6DD1F1797390_CAA0AFEF	for <alsa-devel@alsa-project.org>;
	Mon, 04 Oct 2010 17:12:30 +0000 (GMT)
Received: from localhost ([84.215.109.218]) by get-mta-in03.get.basefarm.net
	(Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20
	2008))
	with ESMTP id <0L9R00DZGZSUKM00@get-mta-in03.get.basefarm.net> for
	alsa-devel@alsa-project.org; Mon, 04 Oct 2010 19:12:30 +0200 (MEST)
In-reply-to: <4CA976B3.9090009@ladisch.de>
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
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch <clemens@ladisch.de> writes:
> Thor Kristoffersen wrote:
>> James Le Cuirot <chewi@aura-online.co.uk> writes:
>> > Sounds like the ASUS Xonar D2X could work for you.
>> 
>> Is it known to work perfectly in ALSA?
>
> Yes.

Okay, that's one candidate.  I did a bit of searching, and I found that
if I relax my requirements a bit to include PCI cards, there is another
card called HT-Omega Claro that would seemingly fit the bill, and it's
significantly cheaper than the Xonar.  Do you (or anyone else) happen to
know if this is also fully supported by ALSA?

By the way, does the volume control work on the digital output stream on
these cards?  That's one thing I like about the X-Fi Titanium; no need
for a softvol plugin.

Thor
