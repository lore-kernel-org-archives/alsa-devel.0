From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: OSS driver removal, 2nd round
Date: Sat, 01 Jul 2006 08:43:24 +0100
Message-ID: <44A6279C.3000100@superbug.co.uk>
References: <20060629192128.GE19712@stusta.de>
	<44A54D8E.3000002@superbug.co.uk>
	<20060630163114.GA12874@dspnet.fr.eu.org>
	<1151702966.32444.57.camel@mindpipe>
	<20060701073133.GA99126@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net
	[194.217.242.85])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E491424D
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Jul 2006 09:43:27 +0200 (MEST)
In-Reply-To: <20060701073133.GA99126@dspnet.fr.eu.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Olivier Galibert <galibert@pobox.com>, Lee Revell <rlrevell@joe-job.com>, James Courtier-Dutton <James@superbug.co.uk>, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, perex@suse.cz, Olaf Hering <olh@suse.de>
List-Id: alsa-devel@alsa-project.org

Olivier Galibert wrote:
> On Fri, Jun 30, 2006 at 05:29:26PM -0400, Lee Revell wrote:
>> Even if you reject this argument, the bug is in ALSA's in-kernel OSS
>> emulation, not the emu10k1 driver.
> 
> That's irrelevant.  You can't remove the oss emu10k1 driver in favor
> of alsa's until alsa provides an equivalent interface.  That's a basic
> compatibility requirement.
> 
> 
>> ALSA's in-kernel OSS emulation does not have these features and
>> never will.
> 
> "Never" is terribly long.
> 
>   OG.

"Never" probably only means terribly long. :-)

If one takes the ALSA todo list, that is massive (it is so long in fact,
that we have not had time to write it all down!), sort it by priority,
then divide by the amount of ALSA developers time available, for this
particular feature, the time to implementation is getting very close to
"Never".

James

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
