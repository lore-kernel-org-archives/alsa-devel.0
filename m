From: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Subject: Re: Alsa with development kernel and devfs.
Date: Sat, 26 Apr 2003 13:27:19 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030426132719.403b03ae.erikd-alsa@mega-nerd.com>
References: <20030426031621.60342.qmail@web10703.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030426031621.60342.qmail@web10703.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 25 Apr 2003 20:16:21 -0700 (PDT)
Jake Burns <burnsjake@yahoo.com> wrote:

> Sorry for the newbie like question but alsa has always
> been confusing to me.  
> 
> I downloaded and installed the new 2.5.68 Linux kernel

Are you sure you want to be running on an unstable kernel? 
A 2.4.X kernel would be much safer.

> and compiled it with alsa directly into the kernel.  
> 
> (I hate modules!)

Do you have any rational reason for hating modules?

> Anyway, I'm using devfs and now there is now /dev/dsp
> link.  I know this probably isn't the best place to
> ask but, how in the heck do I get this working?
> 
> I would prefer not to use modules.

Since the vast majority of people use ALSA as a module, my guess is
that you are pretty much on your own here. However, if you were using
modules, there would probably be a whole bunch of people able to help.

Good luck,
Erik
-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
"Don't be fooled by NT/Exchange propaganda. M$ Exchange is 
just plain broken and NT cannot handle the sustained load 
of a high-volume remote mail server"  
-- Eric S. Raymond in the Fetchmail FAQ


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
