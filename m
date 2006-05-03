From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Non-continous channel map?
Date: Wed, 03 May 2006 14:06:53 +0200
Message-ID: <20060503120653.GA11243@turing.informatik.uni-halle.de>
References: <44505C23.30109@cendio.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.Uni-Halle.DE [141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E091117C
	for <alsa-devel@alsa-project.org>; Wed,  3 May 2006 14:08:03 +0200 (MEST)
In-reply-to: <44505C23.30109@cendio.se>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pierre Ossman <ossman@cendio.se>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pierre Ossman wrote:
> ALSA uses a rather strict default channel map, just a simple list.

Does it?  AFAIK ALSA devices just have a specific number of channels and
leave the interpretation to the application.

The default channel order is just a convention.


HTH
Clemens


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
