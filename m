From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Copy call back for capture substream
Date: Mon, 02 May 2011 14:42:55 +0200
Message-ID: <4DBEA6CF.1090706@ladisch.de>
References: <A3D770027F3D024D8AA74E0D0C630813030CA7E7@PNE-HJN-MBX02.wipro.com>	<4DB93389.3060103@ladisch.de>	<A3D770027F3D024D8AA74E0D0C630813030CAF55@PNE-HJN-MBX02.wipro.com>	<4DBAD7A6.3030502@ladisch.de>
	<A3D770027F3D024D8AA74E0D0C630813031359F6@PNE-HJN-MBX02.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id BAC3C243AC
	for <alsa-devel@alsa-project.org>;
	Mon,  2 May 2011 14:41:39 +0200 (CEST)
In-Reply-To: <A3D770027F3D024D8AA74E0D0C630813031359F6@PNE-HJN-MBX02.wipro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: kshemanth.vasireddi@wipro.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

kshemanth.vasireddi@wipro.com wrote:
> If I want to record both channels in separate files, what command should
> be given to arecord, I am not clear on -I option.

Just give two file names.  Please note that this always results
in raw files.

> The information contained in this electronic message ...

This e-mail contains public information intended for any subscriber of
this mailing list and for anybody else who bothers to read it; it will
be copied, disclosed and distributed to the public.  If you think you
are not the intended recipient, please commit suicide immediately.
These terms apply also to any e-mails quoted in, referenced from, or
answering this e-mail, and supersede any confidentiality notices in
those e-mails.  Additionally, confidentiality notices in those e-mails
will incur legal processing fees of $42 per line; you have agreed to
this by reading this confidentiality notice.


Regards,
Clemens
