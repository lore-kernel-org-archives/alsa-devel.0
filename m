From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: snd-usb-audio - Driver for M-Audio Fast Track Pro
Date: Wed, 09 Aug 2006 05:19:35 +0200
Message-ID: <m2fyg6a94o.fsf@vador.mandriva.com>
References: <20060808181650.llg22g6lwgcs4c0s@zeus.oda.li>
	<1155056548.23266.267914050@webmail.messagingengine.com>
	<20060808202335.1ypdlgq4tckkcwg4@webmail.supelec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060808202335.1ypdlgq4tckkcwg4@webmail.supelec.fr> (Thibault Le
	Meur's message of "Tue, 08 Aug 2006 20:23:35 +0200")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thibault Le Meur <Thibault.LeMeur@supelec.fr> writes:

> For instance I had to introduce the device_setup module parameter in
> order to make my Audiophile USB pre-select 16bits OR 24bits mode
> because switching between the two modes while the device is turned
> on doesn't work:

is it a linux kernel limitation or an harware issue (eg does switching
fork under windows)?

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
