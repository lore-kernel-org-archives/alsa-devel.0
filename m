From: Glenn Maynard <g_sf@zewt.org>
Subject: Re: ALSA API
Date: Sun, 4 Jan 2004 21:11:25 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040105021125.GC27227@zewt.org>
References: <Law10-F99ez3M2L618r00071fef@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Law10-F99ez3M2L618r00071fef@hotmail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 04, 2004 at 05:44:38PM -0800, Alex Lau wrote:
> I try to pass the string "default" to the function, but still get an error 
> -2 (No such file or directory)

Are you sure you've tested an existing ALSA application, to make sure
your installation even works?  (That tends to happen if /dev/snd/*
doesn't exist.)

-- 
Glenn Maynard


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
