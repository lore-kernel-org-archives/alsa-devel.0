From: Benoit Fouet <benoit.fouet@purplelabs.com>
Subject: Re: porting alsa
Date: Mon, 06 Nov 2006 09:51:05 +0100
Message-ID: <454EF779.2020503@purplelabs.com>
References: <454B4067.6060000@freemail.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <454B4067.6060000@freemail.gr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Constantine Kousoulos <wuwei@freemail.gr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi,

Constantine Kousoulos wrote:
> Hello,
>
> Is it possible to port alsa-driver to a non-linux os? If so, what 
> are ALSA's dependencies on the linux kernel that should also be 
> ported in order for alsa-driver to work?
>
> Thanks,
> Constantine
>   

if we trust the ALSA full name (which is what i do), you can not...
i think alsa driver is deeply linked to linux kernel functionning, and
it will not be easy to port it on a non Linux OS

-- Ben


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
