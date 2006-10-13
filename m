From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Issue with Intel HDA
	Sound	card	82801G(laptop	Medion)
Date: Fri, 13 Oct 2006 09:48:22 -0400
Message-ID: <1160747303.24931.120.camel@mindpipe>
References: <1160735680.452f6bc049376@imp2-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1160735680.452f6bc049376@imp2-g19.free.fr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: albox@free.fr
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-10-13 at 12:34 +0200, albox@free.fr wrote:
> Simple mixer control 'Capture',0
>   Capabilities: cvolume cswitch
>   Capture channels: Front Left - Front Right
>   Limits: Capture 0 - 26
>   Front Left: Capture 26 [100%] [off]
>   Front Right: Capture 26 [100%] [off] 

You'll definitely need to unmute "Capture" for it to work...


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
