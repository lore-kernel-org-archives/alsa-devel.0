From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [PATCH] standard control names for the rme96
Date: Tue, 13 May 2003 20:32:33 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030513183233.GA825@tuba.home>
References: <200305111919.h4BJJwlI038695@mail.mega.nu> <20030511235421.GA3610@tuba.home> <s5h1xz3uf43.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h1xz3uf43.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Daniel Pouzzner <douzzer@mega.nu>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, May 13, 2003 at 03:54:04PM +0200, Takashi Iwai wrote:
> 
> let me know if it's ok, so that i'll commit it soon.
> also rmedigicontrol is a good candidate for alsa-tools.  i'll put it
> together with the patch for rme driver.
> 

After some patch in, patch out, patch in -- I've made two versions of the same
code level:

... and rmedigicontrol-0.3.5a is my tools candidate that depends on the rme96
patch. Usage with rme32 is fine.


bye,
martin

See http://langerland.de/rme32/control.html


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
