From: "philicorda" <philicorda@ntlworld.com>
Subject: Problem with echoaudio driver.
Date: Sat, 5 Apr 2003 15:00:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <012301c2fb7b$bc142060$0600a8c0@silverbox>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi. I have got this compiled and installed now, but get the following error
when I try to load the driver...

root@atlantic kernel # modprobe echoaudio
modprobe: Too deep recursion in module dependencies!
modprobe: Circular dependency? OsSupportLinux CEchoGals_info
CEchoGals_transport echoaudio
Aborted
root@atlantic kernel #




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
