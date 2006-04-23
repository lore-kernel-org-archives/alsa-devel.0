From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Remove xrun debugging?
Date: Sun, 23 Apr 2006 12:18:34 -0400
Message-ID: <1145809115.21377.34.camel@mindpipe>
References: <1145767405.21377.20.camel@mindpipe>
	 <20060423174534.1dd2cb44@mango.fruits>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060423174534.1dd2cb44@mango.fruits>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-04-23 at 17:45 +0200, Florian Schmidt wrote:
> On Sun, 23 Apr 2006 00:43:24 -0400
> Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Can the xrun debug feature of ALSA please be removed?  It was obsoleted
> > long ago by the latency tracing feature of the -rt kernel, and has not
> > been used to find a bug since 2004.  At this point it's just confusing
> > to users.
> 
> It still might prove useful for non -rt users. I don't know exactly how
> useful, but maybe it's really a documentation bug. Put a note in the
> helpfile that much finer debugging can be done with the -rt kernels.

I don't think it's useful at all - any bugs that it could have found
were fixed long ago.  I have not seen useful output from it in a year
and a half.

Lee



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
