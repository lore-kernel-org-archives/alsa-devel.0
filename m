From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: What is the status of the "no mic" problem
	on	hda-intel?
Date: Thu, 10 Aug 2006 16:02:34 -0400
Message-ID: <1155240154.20210.19.camel@mindpipe>
References: <1155239705.4989.15.camel@scrat.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1155239705.4989.15.camel@scrat.homelinux.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Mauricio Teixeira <mteixeira@webset.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-08-10 at 16:55 -0300, Mauricio Teixeira wrote:
> Hi!
> 
> I would like to know what is the status of the issue regarding the fact
> that we don't have MIC input on hda-intel based cards. Anyone working on
> that?
> 
> I've checked from bugs #2038 and #2237.
> 

There is no "no mic" problem on hda-intel - the problem is with specific
Sigmatel HDA codecs.

The status is exactly as the bug report says - it doesn't work yet.
Probably no developer has the hardware necessary to debug it.

Lee



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
