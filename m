From: "Adrian McMenamin" <adrian@newgolddream.dyndns.info>
Subject: Re: question about sampling rate
Date: Wed, 12 Jul 2006 09:56:46 +0100 (BST)
Message-ID: <54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
References: <7034e7b50607120105s67644513ned098c960d9ac22b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk
	[81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id D9A4E189
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Jul 2006 10:56:54 +0200 (MEST)
In-Reply-To: <7034e7b50607120105s67644513ned098c960d9ac22b@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Grace Baldonasa <gbaldona@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, July 12, 2006 9:05 am, Grace Baldonasa wrote:
> Hi all,
>
> I have a very simple question regarding the convertion of sampling rate to
> usb full/high speed rate, is this the right mailing list to throw the
> question?
>
> any reply will be greatly appreciate.
> Thanks.
>
You need to be a bit clearer about what it is you want to do. I assume you
are referring to a sound device.

ALSA will automatically handle the sample rate - converting between the
sample rate of the sound you want to play and the capabilities of your
device as specified by the driver.



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
