From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] alsa integer control ranges
Date: Thu, 18 May 2006 07:41:52 +1000
Message-ID: <1147902112.10703.2.camel__18.3200849734888$1147902198$gmane$org@localhost.localdomain>
References: <1147780945.29795.110.camel@johannes>
	 <s5h7j4m40kf.wl%tiwai@suse.de>
	 <1147817023.6753.5.camel@localhost.localdomain>
	 <s5hy7x10y5t.wl%tiwai@suse.de> <1147868218.15507.4.camel@johannes>
	 <s5hd5ec4yn7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2C524238
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 23:41:58 +0200 (MEST)
In-Reply-To: <s5hd5ec4yn7.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Johannes Berg <johannes@sipsolutions.net>, ALSA development <alsa-devel@alsa-project.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Benjamin Berg <benjamin@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-05-17 at 14:35 +0200, Takashi Iwai wrote:

> The question is where to implement a huge table or a complex
> conversion function -- whether in the driver or in alsa-lib.

The lib of course

Ben.




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
