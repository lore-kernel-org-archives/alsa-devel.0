From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: pyalsa: SeqEvent.time strangeness
Date: Tue, 04 Aug 2009 15:03:03 +0200
Message-ID: <4A783187.1070600@ladisch.de>
References: <4A607468.7010300@web.de>	<4A65C370.3030205@ladisch.de>	<4A65EADE.70007@web.de>	<4A733753.60808@web.de>	<4A76D01F.1090603@ladisch.de>	<4A76D662.9030002@web.de>	<4A78033F.5020504@ladisch.de>
	<4A78170B.7070400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2AFE32413F
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 15:02:52 +0200 (CEST)
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id C5A803BEAC7
	for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2009 09:02:48 -0400 (EDT)
Received: from [10.1.2.136] (srv004.schk01.int.dmc-one.com [85.232.8.141])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BD1D813E00
	for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2009 09:02:30 -0400 (EDT)
In-Reply-To: <4A78170B.7070400@web.de>
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

Christopher Arndt wrote:
> Clemens Ladisch schrieb:
> > Please provide a Signed-off-by line.
> 
> Please forgive my ignorance, but what is that? I'm unfamiliar with the
> alsa development process.

It's originally a Linux kernel development process thing, but we use it
for all of ALSA.  See section 12 of
<http://git.alsa-project.org/?p=alsa-kernel.git;a=blob;f=Documentation/SubmittingPatches;hb=HEAD>.


HTH
Clemens
