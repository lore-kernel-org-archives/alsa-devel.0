From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: pcm_min.c
Date: Tue, 11 Jul 2006 21:25:23 -0400
Message-ID: <1152667523.21909.110.camel@mindpipe>
References: <1152635800.21909.47.camel@mindpipe>
	<Pine.LNX.4.61.0607112152000.7907@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0607112152000.7907@tm8103-a.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-07-11 at 21:52 +0200, Jaroslav Kysela wrote:
> On Tue, 11 Jul 2006, Lee Revell wrote:
> 
> > Can someone fix this page:
> > 
> > http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm__min_8c-example.html
> > 
> > It's very useful for responding to people who say ALSA is too
> > complicated, but there's no working copy of pcm_min.c online (at least,
> > Google cannot find one).
> 
> Fixed. Thanks.

Why do snd_pcm_set_params, snd_strerror, snd_pcm_writei, and
snd_pcm_close link to the function documentation, but not snd_pcm_open
and snd_pcm_recover?

Lee



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
