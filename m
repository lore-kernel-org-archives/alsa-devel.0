From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: EMU10KX/Dell PC
Date: Sat, 15 Oct 2005 12:41:30 +0100
Message-ID: <4350EAEA.9030301@superbug.co.uk>
References: <BAY18-F216663D96E337FEFE31CA1E57C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <BAY18-F216663D96E337FEFE31CA1E57C0@phx.gbl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gary Metalle <gary_metalle@hotmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Gary Metalle wrote:
> Hi.
> 
> I have a Dell PC with Creative Labs Live! Value motherboard sound support.
> 
> I've dumped the (verbose) output from lspci below, I hope it helps in 
> some way:
> 

You need the snd-emu10k1x module (note the x at the end.)
You might not have a new enough alsa-driver version.

Check on the wiki troubleshooter at http://alsa.opensrc.org


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
